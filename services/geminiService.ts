
import { GoogleGenAI } from "@google/genai";
import { Quotation } from "../types";

export const generateQuoteSummary = async (quote: Quotation): Promise<string> => {
  const ai = new GoogleGenAI({ apiKey: process.env.API_KEY });
  
  const itemsList = quote.items
    .map(item => `- ${item.product.name} ${item.placeName ? `for ${item.placeName}` : ''} (Qty: ${item.quantity})`)
    .join('\n');

  const prompt = `
    Generate a professional, warm, and persuasive summary for a luxury lighting and premium fan brand called "Magnific".
    
    Customer Name: ${quote.customer.name}
    Items Quoted and their intended locations:
    ${itemsList}
    
    The summary should:
    1. Thank the customer for visiting the Magnific experience center in Koramangala.
    2. Mention how these premium fans and lights will enhance their specific rooms (if locations are provided).
    3. Encourage them to confirm the order to experience the Magnific lifestyle.
    4. Maintain a premium, high-end, and sophisticated tone.
    
    Keep it under 80 words.
  `;

  try {
    const response = await ai.models.generateContent({
      model: 'gemini-3-flash-preview',
      contents: prompt,
    });
    return response.text || "Thank you for choosing Magnific. Our premium range of fans and lights are designed to bring elegance and comfort to your home.";
  } catch (error) {
    console.error("Gemini Error:", error);
    return "Thank you for choosing Magnific. We look forward to helping you illuminate and ventilate your space with our premium designer collection.";
  }
};
