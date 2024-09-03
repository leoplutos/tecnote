using System.ComponentModel.DataAnnotations;

namespace AspWebapi.Models;

// todo表映射
public class TodoEntity
{
	[Key]
	public int TodoId { get; set; }

	public string? TodoName { get; set; }

	public string? Image { get; set; }

	public bool Studied { get; set; }

	public string? SecretKey { get; set; }
}
