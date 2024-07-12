package pe.edu.vallegrande.sistventas.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class UtilController {
	
	
	private UtilController() {
	}
	

	public static void responseJson(HttpServletResponse response, String data) {
		try {
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			out.print(data);
			out.flush();
		} catch (Exception e) {
		}
	}

	public static void responseText(HttpServletResponse response, String texto) {
		try {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			out.print(texto);
			out.flush();
		} catch (Exception e) {
		}
	}

}
