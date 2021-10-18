package usuarios.javadabadu.manager;

public class UserManager {
    private static UserManager manager;

    private UserManager() {
    }

    public static UserManager getManager() {
        if(manager == null){
            manager = new UserManager();
        }
        return manager;
    }
}
