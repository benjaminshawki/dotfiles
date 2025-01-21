beforeEach( () => {
    cy.visit("/");
});

it( 'Should login when provided correct credentials', () => {
    cy.get('#login-button').click();
