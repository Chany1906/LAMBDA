import json

def lambda_handler(event, context):
    # Simula limpieza y guarda JSON
    print("Procesando archivo...")
    return {"statusCode": 200, "body": json.dumps("OK")}
