using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Consumir_WebApi2_Produtos
{
    class Program
    {
        static void Main(string[] args)
        {
            RunAsync().Wait();

            Console.ReadKey();
        }

        static async Task RunAsync()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new System.Uri("http://localhost:53557/");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                MostrarProdutos(client);

                Produto produtoCha = new Produto() { Nome = "Chá", Categoria = "Bebidas", Preco = 1.50M };

                HttpResponseMessage response = await client.PostAsJsonAsync("api/produtos", produtoCha);

                if (response.IsSuccessStatusCode)
                {
                    MostrarProdutos(client);

                    Console.WriteLine("Produto cha verde incluído. Tecle algo para continuar");
                    Console.ReadKey();

                    Uri urlProdutoCha = response.Headers.Location;
                    produtoCha.Preco = 2.50M;
                    response = await client.PutAsJsonAsync(urlProdutoCha, produtoCha);

                    Console.WriteLine("Produto preço do atualizado. Tecle algo para excluir o produto");
                    Console.ReadKey();

                    MostrarProdutos(client);

                    response = await client.DeleteAsync(urlProdutoCha);
                    Console.WriteLine("Produto deletado");
                    Console.ReadKey();
                }
            }
        }

        static async void MostrarProdutos(HttpClient client)
        {
            HttpResponseMessage response = await client.GetAsync("/api/produtos");

            if (response.IsSuccessStatusCode)
            {
                IEnumerable<Produto> listaProduto = await response.Content.ReadAsAsync<IEnumerable<Produto>>();

                foreach (var produto in listaProduto)
                {
                    Console.WriteLine("{0}\tR${1}\t{2}\n", produto.Nome, produto.Preco, produto.Categoria);
                }

                Console.WriteLine("Produtos acessados e exibidos. Tecle algo para continuar!");
                Console.ReadKey();
            }
        }
    }
}
