// https://docs.cypress.io/api/table-of-contents

describe('Authentication', () => {
  beforeEach(() => {
    cy.visit(Cypress.env('VUE_APP_FRONTEND_URL') + '/login');
  });

  it('Should register when provided correct credentials', () => {
    cy.visit(Cypress.env('VUE_APP_FRONTEND_URL') + '/register');
    cy.get('#register-username').type('testuser');
    cy.get('#register-email').type('testuser@mail.com');
    cy.get('#register-password').type('Password123!');
    cy.get('#register-repeat-password').type('Password123!');
    cy.get('#register-button').click();
  });

  it('Should login when provided correct credentials', () => {
    cy.get('#login-email').type('testuser@mail.com');
    cy.get('#login-password').type('Password123!');
    cy.get('#login-button').click();
  });
});
