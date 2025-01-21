// https://docs.cypress.io/api/table-of-contents

describe('Environmental variables should result in page visit', () => {
  it('Frontend environment should be accesible', () => {
    cy.visit(Cypress.env('VUE_APP_FRONTEND_URL'));
  });
});
