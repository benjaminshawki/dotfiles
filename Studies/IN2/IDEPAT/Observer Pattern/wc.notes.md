Applicatie model

Obserer pattern Push en Pull

**Push**
```java
public interface Observer {
    void update(Observable o);
}
```

**Pull**
```java
public interface Observer {
    void update();
}
```