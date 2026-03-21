
package service;

import java.util.List;
import model.Issue;
import DAO.IssueDAO;
public class IssueService {
    private IssueDAO dao=new IssueDAO();
    public List<Issue> getAll(){
        return dao.getAllIssues();
    }
    public void insert(Issue issue){
        dao.insert(issue);
    }
}
