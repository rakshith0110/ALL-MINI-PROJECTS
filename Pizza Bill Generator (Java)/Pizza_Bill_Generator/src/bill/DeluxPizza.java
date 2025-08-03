package bill;

public class DeluxPizza extends Pizza {


    public DeluxPizza(boolean isVeg) {
        super(isVeg);
        
        super.addExtraCheese();
        super.addExtraToppings();
    }


    @Override
    public void addExtraCheese() {
    }


    @Override
    public void addExtraToppings() {
    }
}