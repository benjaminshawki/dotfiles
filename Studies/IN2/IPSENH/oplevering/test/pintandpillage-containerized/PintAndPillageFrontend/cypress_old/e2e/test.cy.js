// https://docs.cypress.io/api/table-of-contents

describe('Testing environmental variables', () => {
  beforeEach(() => {
    // cy.visit(process.env.FRONTEND_URL);
    // cy.visit(`http://${cy.env('FRONTEND_URL')}`);
  });
  it('Frontend environment should be accesible', () => {
    cy.visit(Cypress.env('VUE_APP_FRONTEND_URL'));
  });
 });
