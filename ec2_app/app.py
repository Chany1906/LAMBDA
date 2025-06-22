from flask import Flask, jsonify
import boto3
import os

app = Flask(__name__)

# Configura tu bucket y región
S3_BUCKET = "my-data-bucket-simple"
REGION = "us-east-1"

# Cliente de S3
s3 = boto3.client("s3", region_name=REGION)

@app.route("/data-json/<file_id>")
def get_json(file_id):
    try:
        # Nombre del archivo en S3
        key = f"{file_id}.json"

        # Descargar contenido como string
        response = s3.get_object(Bucket=S3_BUCKET, Key=key)
        content = response["Body"].read().decode("utf-8")

        return jsonify({"file_id": file_id, "content": content})

    except Exception as e:
        return jsonify({"error": str(e)}), 404

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
