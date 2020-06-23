package at.htl.junglehunter.entity;

import io.quarkus.elytron.security.common.BcryptUtil;
import io.quarkus.hibernate.orm.panache.PanacheEntity;
import io.quarkus.security.jpa.Password;
import io.quarkus.security.jpa.Roles;
import io.quarkus.security.jpa.UserDefinition;
import io.quarkus.security.jpa.Username;
import org.apache.commons.lang3.RandomStringUtils;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.transaction.Transactional;
import java.util.UUID;

@Entity
@Table(name = "_user")
@UserDefinition
public class User extends PanacheEntity {

    @Username
    public String username;

    @Password
    public String password;

    @Roles
    public String role;

    public String email;

    @Transactional
    public static User create(String username, String password) {
        User user = new User();
        user.username = UUID.randomUUID().toString().replace("-", "");
        user.password = BcryptUtil.bcryptHash(RandomStringUtils.random(10));
        user.role = "user";
        user.persist();

        return user;
    }
}
