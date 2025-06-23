import json
import pandas as pd
import boto3
import matplotlib.pyplot as plt
from io import BytesIO
import base64

s3_client = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    # Descargar CSV
    obj = s3_client.get_object(Bucket=bucket, Key=key)
    df = pd.read_csv(BytesIO(obj['Body'].read()))
    
    # Análisis
    stock_por_marca = df.groupby('MARCA AUTOMOVIL')['STOCK'].sum().to_dict()
    promedio_stock = df.groupby('MODELO')['STOCK'].mean().to_dict()
    
    # Visualización
    plt.figure()
    df.groupby('MARCA PRODUCTO')['STOCK'].sum().plot(kind='bar')
    img = BytesIO()
    plt.savefig(img, format='png')
    img.seek(0)
    img_base64 = base64.b64encode(img.read()).decode('utf-8')
    
    # Reporte
    reporte = {
        'stock_por_marca': stock_por_marca,
        'promedio_stock': promedio_stock,
        'visualizacion': f'<img src="data:image/png;base64,{img_base64}">'
    }
    
    # Guardar reporte JSON
    json_key = key.replace('.csv', '.json')
    s3_client.put_object(
        Bucket='output-bucket-name',
        Key=json_key,
        Body=json.dumps(reporte)
    )
    
    # Guardar reporte HTML
    html_key = key.replace('.csv', '.html')
    html_content = f"""
    <html><body>
        <h1>Reporte de Stock</h1>
        <h2>Stock por Marca</h2>
        <pre>{json.dumps(stock_por_marca, indent=2)}</pre>
        <h2>Visualización</h2>
        {reporte['visualizacion']}
    </body></html>"""
    s3_client.put_object(
        Bucket='output-bucket-name',
        Key=html_key,
        Body=html_content,
        ContentType='text/html'
    )
    
    # Registrar en DynamoDB
    tabla = dynamodb.Table('HistorialEjecucion')
    tabla.put_item(Item={
        'nombre_archivo': key,
        'fecha': context.get_remaining_time_in_millis(),
        'estado': 'exito'
    })
    
    return {'statusCode': 200, 'body': 'Reporte generado'}