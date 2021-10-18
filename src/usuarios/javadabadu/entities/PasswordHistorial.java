package usuarios.javadabadu.entities;

public class PasswordHistorial {
    private Integer idPasswordHistorial;
    private Integer idUser;
    private String password;

    public PasswordHistorial() {
    }

    public Integer getIdPasswordHistorial() {
        return idPasswordHistorial;
    }

    public void setIdPasswordHistorial(Integer idPasswordHistorial) {
        this.idPasswordHistorial = idPasswordHistorial;
    }

    public Integer getIdUser() {
        return idUser;
    }

    public void setIdUser(Integer idUser) {
        this.idUser = idUser;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
