from fastapi import FastAPI, UploadFile, File
import tensorflow as tf
import numpy as np
from PIL import Image
import io
from genai_engine import get_agronomy_advice
import uvicorn

app = FastAPI()

# Load model
model = tf.keras.models.load_model('DenseNet121_final_model.keras')
labels = ['Healthy', 'Late Blight', 'Early Blight'] # Update classes as per your dataset

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    # 1. Process Image
    request_object_content = await file.read()
    img = Image.open(io.BytesIO(request_object_content)).resize((224, 224))
    img_array = np.expand_dims(tf.keras.preprocessing.image.img_to_array(img) / 255.0, axis=0)

    # 2. Inference (REST API)
    predictions = model.predict(img_array)
    predicted_class = labels[np.argmax(predictions)]

    # 3. GenAI Infusion
    advice = get_agronomy_advice(predicted_class)

    return {
        "prediction": predicted_class,
        "agronomy_agent_advice": advice
    }

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5000)