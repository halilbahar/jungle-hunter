package at.htl.junglehunter.resource;

import at.htl.junglehunter.dto.UserDto;
import at.htl.junglehunter.entity.User;
import io.quarkus.elytron.security.common.BcryptUtil;
import org.apache.commons.lang3.RandomStringUtils;

import javax.transaction.Transactional;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;
import java.util.UUID;

@Path("/user")
@Consumes("application/json")
@Produces("application/json")
public class UserResource {

    @GET
    @Transactional
    public Response getTempUser() {
        String secureChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~`!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?";
        String password = RandomStringUtils.random(10, secureChars);
        String uuid = UUID.randomUUID().toString().replace("-", "");
        User user = User.create(uuid, password);
        UserDto userDto = UserDto.map(user);
        userDto.setPassword(password);

        return Response.ok(userDto).build();
    }
}
