package pe.edu.vallegrande.sistventas.prueba;

import pe.edu.vallegrande.sistventas.db.AccesoDB;

import java.sql.Connection;

public class Prueba01 {

    public static void main(String[] args) {
        try {
            Connection cn = AccesoDB.getConnection();
            System.out.println("Ok.");
            cn.close();
        }catch (Exception e){
            System.err.println(e.getMessage());
        }
    }
}
