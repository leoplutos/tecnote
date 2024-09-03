using System.ComponentModel.DataAnnotations;

namespace AspWebapi.Models;

// login表映射
public class LoginEntity
{
	[Key]
	public required string UserId { get; set; }

	public required string Password { get; set; }

}
