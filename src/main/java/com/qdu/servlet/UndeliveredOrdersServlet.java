import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;
import com.qdu.dao.impl.OrderDaoImpl;
import com.qdu.model.Order;
import com.qdu.model.Users;

public class UndeliveredOrdersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Users loggedUser = (Users) session.getAttribute("LoggedUser");
        int uid = loggedUser.getUid();

        OrderDaoImpl orderDao = new OrderDaoImpl();
        List<Order> orders = orderDao.getUndeliveredOrders(uid);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        for (Order order : orders) {
            out.println("<div class='cart-row'>");
            out.println("<div>");
            out.println("<strong>" + order.getB_name() + "</strong><br>");
            out.println("订单编号：" + order.getOid() + "<br>");
            out.println("收货人姓名：" + order.getReceiver_name() + "<br>");
            out.println("客户联系方式：" + order.getBuyer_tel() + "<br>");
            out.println("邮政编码：" + order.getPostal_code() + "<br>");
            out.println("收货地址：" + order.getBuyer_address() + "<br>");
            out.println("下单日期：" + order.getOrder_date() + "<br>");
            out.println("数量：<input type='number' id='qty-" + order.getBook_num() + "' value='" + order.getBook_num() + "' min='1' style='width: 50px;' readonly><br>");
            out.println("总价：" + order.getSum_price() + "<br>");
            out.println("状态：");
            if(order.getOrder_type() == 1){
                out.println("已送达<br>");
            }else if(order.getOrder_type() == 0){
                out.println("运输中<br>");
            }else if(order.getOrder_type() == -1){
                out.println("已退货<br>");
            }
            out.println("</div>");
            out.println("<div class='cart-actions'>");
            out.println("<button class='btn btn-sm btn-danger' onclick='showDeleteModal(\"" + order.getOid() + "\", \"" + order.getB_name() + "\")'>删除订单</button>");
            out.println("<button class='btn btn-sm btn-warning' onclick='showReturnModal(\"" + uid + "\", \"" + order.getOid() + "\")'>退货</button>");
            out.println("<button class='btn btn-sm btn-success' onclick='showConfirmReceivedModal(\"" + uid + "\", \"" + order.getOid() + "\")'>确认收货</button>");
            out.println("</div>");
            out.println("</div>");
        }
    }
}
