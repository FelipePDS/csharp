using System.ComponentModel.DataAnnotations;

namespace CRUDUsingMVCWithAdoNet.Models
{
    public class Pessoa
    {
        public int ID { get; set; }

        [Required(ErrorMessage = "O campo nome é obrigatório.")]
        public string Nome { get; set; }

        public string Email { get; set; }

        public string Cidade { get; set; }

        public string Endereco { get; set; }
    }
}