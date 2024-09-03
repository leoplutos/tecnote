using AspWebapi.Models;

namespace AspWebapi.Services;

//######################################
// Service层
//######################################
public interface ILoginService
{
	public Task<LoginEntity> FindByUserIdAndPassword(string userId, string password);
}
