package service;

import DAO.SettingDAO;
import model.Setting;

import java.sql.SQLException;
import java.util.List;

public class SettingService {
    private final SettingDAO settingDAO;

    public SettingService() {
        this.settingDAO = new SettingDAO();
    }

    public List<Setting> getAllSettings() throws SQLException {
        return settingDAO.getAllSettings();
    }

    public List<Setting> getSettingsByFilter(String name, String type, String status) throws SQLException {
        return settingDAO.getSettingsByFilter(name, type, status);
    }

    public Setting getSettingById(int id) throws SQLException {
        return settingDAO.getSettingById(id);
    }

    public List<String> getAllTypes() throws SQLException {
        return settingDAO.getAllTypes();
    }

    public boolean createSetting(Setting setting) throws SQLException {
        if (setting.getName() == null || setting.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Setting name is required");
        }
        if (setting.getType() == null || setting.getType().trim().isEmpty()) {
            throw new IllegalArgumentException("Setting type is required");
        }
        if (setting.getValue() == null || setting.getValue().trim().isEmpty()) {
            throw new IllegalArgumentException("Setting value is required");
        }
        return settingDAO.createSetting(setting);
    }

    public boolean updateSetting(Setting setting) throws SQLException {
        if (setting.getName() == null || setting.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Setting name is required");
        }
        if (setting.getType() == null || setting.getType().trim().isEmpty()) {
            throw new IllegalArgumentException("Setting type is required");
        }
        if (setting.getValue() == null || setting.getValue().trim().isEmpty()) {
            throw new IllegalArgumentException("Setting value is required");
        }
        return settingDAO.updateSetting(setting);
    }

    public boolean deleteSetting(int id) throws SQLException {
        return settingDAO.deleteSetting(id);
    }
}
