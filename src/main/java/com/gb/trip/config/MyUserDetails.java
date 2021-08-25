package com.gb.trip.config;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.gb.trip.model.User;

import lombok.Data;

@Data
public class MyUserDetails implements UserDetails, OAuth2User{
    private static final long serialVersionUID = 1L;


    private User user;
    private Map<String,Object> attributes;


//    final boolean accountNonExpired = true;
//    final boolean accountNonLocked = true;
//    final boolean credentialsNonExpired = true;
//    final String password;
//    final String username;
//    final boolean isEnabled;
//    Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();

//    final String name;
//    final String email;
//    final String role;


    public MyUserDetails(User user) {
//        switch (user.getRole()) {
//        case "관리자": authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN")); break;
//        case "유저": authorities.add(new SimpleGrantedAuthority("ROLE_USER")); break;
//        }
//        this.username = user.getUsername();
//        this.password = user.getPassword();
//        this.isEnabled = user.isEnabled();
//
//        this.name = user.getName();
//        this.email = user.getEmail();
//        this.role = user.getRole();
    	this.user = user;
    }
    public MyUserDetails(User user, Map<String,Object> attributes) {
    	this.user = user;
    	this.attributes = attributes;

    }


	@Override
	public Map<String, Object> getAttributes() {
		// TODO Auto-generated method stub
		return attributes;
	}
	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return user.getName();
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collect = new ArrayList<>();
		/*
		 * collect.add(new GrantedAuthority() {
		 *
		 * @Override public String getAuthority() { // TODO Auto-generated method stub
		 * return user.getRole(); } }); return collect;
		 */
		collect.add(()->{return user.getRole();});
		return collect;
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return user.getPassword();
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return user.getUsername();
	}

	public String getEmail() {
		return user.getEmail();
	}

	public String getRole() {
		return user.getRole();
	}
	public String getNickname() {
		return user.getNickname();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

}
