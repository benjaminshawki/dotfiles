# Week: 2
# Subject: Testing

Unit testing -> Integratie testing -> Systeem testing -> Acceptatie testing

## Unit testing

Testen van kleinste component van de code.

Automated / manual

Alle unittest samen werkend? 

Unit test moet zo klein mogelijk zijn, wat is de kleinste eenheid


## Triple-A

### Arrange

### Act

### Assert

```java
@Test
void testPlus() {
    //Arrange
    var cash = new Cash(10);
    //Act
    cash.plus(5);
    //Assert
    assertEquals(15, cash.getAmount());
}
```

Bovenstaande kan beter, Actual en Expected amount.

## oefening naamgeving les

Should_Quack_When_MakesASound
When_MakesASound_Then_Quack

## Tooling
- Java
  - Junit 5
  - Hamcrest
  - Mockito

### Junit 5
- @Test
- @BeforeEach
- @BeforeAll
- @Tag
- @Suite

### Hamcrest
- assertThat
- is
- instaceOf

```java
@Test
public void givenObject_whenHasValue_thenCorrect() {
    Cat cat = new Cat("kitty");
    assertThat(cat, is(instanceOf(Cat.class)));
}
```

## Dependencies afhandelen
- Mocks
- Stubs
- Fakes
- Dummies
- Spies

@MartinFowler

### Mocks
### Stubs
k
### Dummy

###

