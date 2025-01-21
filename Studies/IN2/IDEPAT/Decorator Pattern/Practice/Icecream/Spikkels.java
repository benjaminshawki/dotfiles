public class Spikkels extends IceCreamDecorator {
    public Spikkels(IceCream iceCream){
        this.iceCream = iceCream;
    }

    @Override
    public double cost() {
        return iceCream.cost() + .1;
    }
}
