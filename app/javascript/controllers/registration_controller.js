// app/javascript/controllers/registration_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Registration Controller connected")
  }

  // Método para lidar com a submissão do formulário
  handleSubmit(event) {
    // Seleciona os campos de senha e email
    const passwordField = this.element.querySelector('input[name="user[password]"]');
    const emailField = this.element.querySelector('input[name="user[email]"]');
    
    const password = passwordField.value;
    const email = emailField.value;

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
      event.preventDefault(); // Impede a submissão do formulário
      alert("Por favor, insira um email válido.");
      return; // Sai da função
    }

    // Verifica se a senha tem pelo menos 6 caracteres
    if (password.length < 6) {
      event.preventDefault(); // Impede a submissão do formulário
      alert("A senha deve ter pelo menos 6 caracteres.");
      return; // Sai da função
    }

    // Valida o formato do email
  
    // Se as validações passarem, você pode continuar com a lógica adicional
    console.log("Form submitted")
  }
}
