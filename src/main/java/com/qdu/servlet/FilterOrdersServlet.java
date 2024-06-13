import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.model.Order;
import com.qdu.model.Users;
import com.google.gson.Gson;

public class FilterOrdersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Users loggedUser = (Users) session.getAttribute("LoggedUser");
        int uid = loggedUser.getUid();

        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;

        try {
            startDate = sdf.parse(startDateStr);
            endDate = sdf.parse(endDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
            return;
        }

        OrderDaoImpl orderDao = new OrderDaoImpl();
        List<Order> orderList = orderDao.getOrdersWithinTimeFrame(uid, startDate, endDate);

        Gson gson = new Gson();
        String jsonResponse = gson.toJson(orderList);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
    }
}
