using System.ComponentModel.DataAnnotations;

namespace TesteFadami.Models
{
    public class UsuariosComTelefone
    {
        public int UsuarioId { get; set; }
        public string Nome { get; set; }
        public string Sobrenome { get; set; }
        public string Cpf { get; set; }
        public string Email { get; set; }
        public DateTime DataDeNascimento { get; set; }
        public int Status { get; set; }
        public string CodigoDeArea { get; set; }
        public string Telefone { get; set; }
    }
}
