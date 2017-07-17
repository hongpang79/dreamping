package board;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Board extends HttpServlet {

	private static final long serialVersionUID = 1L;
	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 requestPro(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 requestPro(request,response);
	}

	private void requestPro(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		String step = request.getParameter("step");
		String category = request.getParameter("category");
		String path = "";
		
		if(step == null){
			step = "list";
		}
//		System.out.println("step : " + step);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				
		if(step.equals("list")){
			BoardDAO bd = new BoardDAO();
			int start = Integer.parseInt(request.getParameter("start"));
			int end = Integer.parseInt(request.getParameter("end"));
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			List<BoardVO> list = null;
			String result = "";
			String expoCont = "<div class='element expoCont'><a href='/board/view.jsp?num=";
			String param = "&pageNum="+currentPage+"&category="+category+"&action=review";
			String imgs = "'><img src='";
			String imge = "' alt='' /></a>";
			String dl = "<dl><dt class='fs_14 mgb05'><a href='/board/view.jsp?num=";
			String dt = "'>";
			String dd = "</a></dt><dd><p class='fc_02 mgb15 web_only'>";
			String p = "</p><p class='fc_05'><span class='letter_zero mgr15'>";
			String span = "</span><span>조회 : <span class='letter_zero'>";
			String spane = "</span></span></p></dd></dl></div>";
			try {
//				System.out.println("[Board][step : list] param : " + start + ", " + end + ", " + currentPage);
				if(currentPage > 1){
					start = start + (10 * (currentPage-1));
					// end = end + (10 * (currentPage-1)); // ORACLE
				}
//				System.out.println("[Board][step : list] start : " + start + " , end : " + end);
				list = bd.getArticles(start, end, category);
				int cnt = list.size();
				if(cnt > 0){
					for(int i=0; i<cnt; i++){
						BoardVO article= new BoardVO();
						article = list.get(i);
						result = result + expoCont + article.getNum() + param + imgs + article.getThumbImgUrl() + imge;
						result = result + dl + article.getNum() + param + dt + article.getSubject() + dd;
						String str = article.getDescription().replaceAll("<[^>]*>", " ");
						if(str.length() > 98){
							result = result + str.substring(0,98) + p;
						}else{
							result = result + str + p;
						}						
						result = result + sdf.format(article.getRegDate()) + span + article.getReadCount() + spane;
					}
					
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//JSONObject obj = new JSONObject();
			//obj.put("data", result);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(result);
			System.out.println("data = " + result);
		}else if(step.equals("passwordChk")){
			int num = Integer.parseInt((String) request.getParameter("num"));
//			String pageNum = request.getParameter("pageNum");
			String password = request.getParameter("b_passwd");
			try {
				BoardDAO bd = new BoardDAO();
				int rtn = bd.getPasswordCheck(num, password);
				response.setContentType("text/html; charset=UTF-8");
		    	if(rtn == 0){
		    		PrintWriter pr=response.getWriter();
					pr.println("<html>");
					pr.println("<head><script language='JavaScript'>");
					pr.println("alert('비밀번호가 틀렸습니다.');");
					if(category.equals("group")){
						pr.println("location.href='/board/list.jsp?action=board&category=group';");
					}else{
						pr.println("location.href='/board/list.jsp?action=board&category=qna';");
					}
					pr.println("</script>");
					pr.println("</head></html>");
		    	}else{
		    		path = "/board/view.jsp";
		    		BoardVO board = bd.getArticle(num);
					request.setAttribute("board", board);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher(path);
					dispatcher.forward(request,	response);
				}
		    	System.out.println("passwordChk = " + rtn);	
	    	} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}

}
