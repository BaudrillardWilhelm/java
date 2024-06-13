import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.model.Users;

@WebServlet("/OrderClearServlet")
public class OrderClearServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Users loggedUser = (Users) session.getAttribute("LoggedUser");
        int uid = loggedUser.getUid();

        OrderDaoImpl orderDao = new OrderDaoImpl();

        int  result = orderDao.clearOrder(uid);

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print((result==1) ? 1 : 0);
    }
}
