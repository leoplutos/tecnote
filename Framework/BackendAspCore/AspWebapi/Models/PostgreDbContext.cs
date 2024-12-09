using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AspWebapi.Models;

// 设定PostgreDb的ORM
// 数据库访问上下文(使用Microsoft.EntityFrameworkCore)
public class PostgreDbContext : DbContext
{
	// 构造函数
	public PostgreDbContext(DbContextOptions<PostgreDbContext> options) : base(options)
	{
	}

	// t_employee表
	public DbSet<Employee> Employees { get; set; } = null!;

}

// t_employee表的映射（Entities）
[Table("t_employee")]
//[Index(nameof(EmployeeId))]
public class Employee
{
	[Key]
	[Column("te_pk")]
	public Guid TePk { get; set; }

	[Column("employee_id")]
	public string? EmployeeId { get; set; }

	[Column("employe_name")]
	public string? EmployeName { get; set; }

	[Column("employe_email")]
	public string? EmployeEmail { get; set; }

	[Column("employe_status")]
	public int? EmployeStatus { get; set; }

	// 重写 ToString() 方法, 以方便日志输出
	public override string ToString()
	{
		return $"TePk: {TePk}, EmployeeId: {EmployeeId}, EmployeName: {EmployeName}, EmployeEmail: {EmployeEmail}, EmployeStatus: {EmployeStatus}";
	}
}
