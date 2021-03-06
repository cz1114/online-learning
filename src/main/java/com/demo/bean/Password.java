package com.demo.bean;

public class Password {
    private String oldPassword;
    private String password;
    private String repassword;

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRepassword() {
        return repassword;
    }

    public void setRepassword(String repassword) {
        this.repassword = repassword;
    }

    @Override
    public String toString() {
        return "Password{" +
                "oldPassword='" + oldPassword + '\'' +
                ", password='" + password + '\'' +
                ", repassword='" + repassword + '\'' +
                '}';
    }
}
