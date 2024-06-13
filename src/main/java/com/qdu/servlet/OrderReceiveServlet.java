import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import com.qdu.dao.impl.OrderDaoImpl;

@WebServlet("/OrderReceiveServlet")
public class OrderReceiveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int oid = Integer.parseInt(request.getParameter("oid"));
        int uid = Integer.parseInt(request.getParameter("uid"));
        OrderDaoImpl orderDao = new OrderDaoImpl();

        int result = orderDao.ConfirmReceivedOrder(uid, oid);

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print((result==1) ? 1 : 0);
    }
}
