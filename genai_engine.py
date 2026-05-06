import google.generativeai as genai

# Configure your API Key
genai.configure(api_key="AIzaSyCYdktIJwsxaCUFicg-pEM1AfOlNcOV8bo")
model = genai.GenerativeModel('gemini-1.5-flash')

def get_agronomy_advice(disease_name, plant_type="Crop"):
    prompt = f"""
    The AI model 'LeafGuard' has detected {disease_name} on a {plant_type}.
    As an AI Agronomy Agent, provide:
    1. A brief explanation of the disease.
    2. Three immediate organic or chemical treatment steps.
    3. How managing this disease contributes to SDG 2 (Zero Hunger).
    Keep the response concise for a mobile app interface.
    """
    response = model.generate_content(prompt)
    return response.text