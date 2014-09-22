package org.auscope.portal.server.web.security;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.auscope.portal.core.server.security.oauth2.GoogleOAuth2UserDetailsLoader;
import org.auscope.portal.core.server.security.oauth2.PortalUser;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * Loader for user access permissions keyed by Google OAuth2 email address.
 * 
 * @author Ben Caradoc-Davies, CSIRO Mineral Resources Flagship
 */
public class EmailGoogleOAuth2UserDetailsLoader extends
        GoogleOAuth2UserDetailsLoader {

    private final Log logger = LogFactory.getLog(getClass());

    public EmailGoogleOAuth2UserDetailsLoader(String defaultRole) {
        super(defaultRole);
    }

    public EmailGoogleOAuth2UserDetailsLoader(String defaultRole,
            Map<String, List<String>> rolesByUser) {
        super(defaultRole, rolesByUser);
    }

    @Override
    public UserDetails createUser(String id, Map<String, Object> userInfo) {
        logger.info(userInfo.toString());
        List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority(defaultRole));
        // trust only verified email addresses
        if (rolesByUser != null && userInfo.containsKey("verified_email")
                && userInfo.get("verified_email").equals(true)) {
            List<SimpleGrantedAuthority> additionalAuthorities = rolesByUser
                    .get(userInfo.get("email").toString());
            if (additionalAuthorities != null) {
                authorities.addAll(additionalAuthorities);
            }
        }
        PortalUser newUser = new PortalUser(id, "", authorities);
        applyInfoToUser(newUser, userInfo);
        return newUser;
    }

}
