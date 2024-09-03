namespace AspWebapi.Models;

// 防止过度发布，将Entiy转换成DTO
public class TodoDTO
{
	public int TodoId { get; set; }

	public string? TodoName { get; set; }

	public string? Image { get; set; }

	public bool Studied { get; set; }
}
