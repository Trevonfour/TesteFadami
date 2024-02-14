using Dapper;
using Microsoft.AspNetCore.Mvc;
using NuGet.Protocol;
using NuGet.Protocol.Plugins;
using System;
using System.Data;
using System.Data.SqlClient;
using TesteFadami.Models;

namespace TesteFadami.Controllers
{
    public class UsuariosComTelefoneController : Controller
    {
        private readonly string connectionString = "Server=(localdb)\\MSSQLLocalDB;Database=TESTEFADAMI;User Id=teste;Password=1234;";

        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public IActionResult RetornarTodos()
        {
            try
            {
                string selecaoQuery = "exec CONSULTAR_TODOS_USUARIOS_COM_TELEFONE;";

                using (IDbConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    var result = connection.Query(selecaoQuery);
                    return Json(result);

                }
                
            }
            catch (Exception ex)
            {
                return BadRequest("Ocorreu um erro ao recuperar os usuários: " + ex.Message);
            }
        }

        [HttpPost]
        public IActionResult NovoUsuario(UsuariosComTelefone usuarioComTelefone)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    string insercaoQuery = "exec INSERIR_USUARIO_E_TELEFONE @NM_NOME, @NM_SOBRE_NOME, @CPF, @EMAIL, @DH_NASCIMENTO, @DDD, @TELEFONE;";

                    using (IDbConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        var parametros = new
                        {
                            NM_NOME = usuarioComTelefone.Nome,
                            NM_SOBRE_NOME = usuarioComTelefone.Sobrenome,
                            CPF = usuarioComTelefone.Cpf,
                            EMAIL = usuarioComTelefone.Email,
                            DH_NASCIMENTO = usuarioComTelefone.DataDeNascimento,
                            DDD = usuarioComTelefone.CodigoDeArea,
                            TELEFONE = usuarioComTelefone.Telefone
                        };

                        var result = connection.Query(insercaoQuery, parametros);
                        return Json(result);
                    }
                }
                catch (Exception ex)
                {
                    return BadRequest("Ocorreu um erro ao criar o usuário: " + ex.Message);
                }
            }
            return BadRequest(ModelState);
        }

        [HttpGet]
        public IActionResult RetornarPorId(UsuariosComTelefone usuarioComTelefone)
        {
            try
            {
                string selecaoQuery = "exec CONSULTAR_USUARIO_COM_TELEFONE @CD_USUARIO;";
                using (IDbConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    var parametro = new
                    {
                        CD_USUARIO = usuarioComTelefone.UsuarioId
                    };
                    var result = connection.QueryFirstOrDefault(selecaoQuery, parametro);
                    return Json(result);
                }

            }
            catch (Exception ex)
            {
                return BadRequest("Ocorreu um erro ao recuperar os usuários: " + ex.Message);
            }
        }

        [HttpPost]
        public IActionResult AtualizarUsuario(UsuariosComTelefone usuarioComTelefone)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    string insercaoQuery = "exec ATUALIZAR_USUARIO @CD_USUARIO, @NM_NOME, @NM_SOBRE_NOME, @CPF, @EMAIL, @DH_NASCIMENTO, @DDD, @TELEFONE;";

                    using (IDbConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        var parametros = new
                        {
                            CD_USUARIO = usuarioComTelefone.UsuarioId,
                            NM_NOME = usuarioComTelefone.Nome,
                            NM_SOBRE_NOME = usuarioComTelefone.Sobrenome,
                            CPF = usuarioComTelefone.Cpf,
                            EMAIL = usuarioComTelefone.Email,
                            DH_NASCIMENTO = usuarioComTelefone.DataDeNascimento,
                            DDD = usuarioComTelefone.CodigoDeArea,
                            TELEFONE = usuarioComTelefone.Telefone
                        };

                        var result = connection.Query(insercaoQuery, parametros);
                        return Json(result);
                    }
                }
                catch (Exception ex)
                {
                    return BadRequest("Ocorreu um erro ao criar o usuário: " + ex.Message);
                }
            }
            return BadRequest(ModelState);
        }

        [HttpPost]
        public IActionResult ExcluirUsuario(UsuariosComTelefone usuarioComTelefone)
        {
            try
            {
                string selecaoQuery = "exec EXCLUIR_USUARIO_E_TELEFONE @CD_USUARIO;";
                using (IDbConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    var parametro = new
                    {
                        CD_USUARIO = usuarioComTelefone.UsuarioId
                    };
                    var result = connection.Query(selecaoQuery, parametro);
                    return Json(result);
                }

            }
            catch (Exception ex)
            {
                return BadRequest("Ocorreu um erro ao recuperar os usuários: " + ex.Message);
            }
        }

        [HttpPost]
        public IActionResult DesativarUsuario(UsuariosComTelefone usuarioComTelefone)
        {
            try
            {
                string selecaoQuery = "exec DESATIVAR_USUARIO @CD_USUARIO;";
                using (IDbConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    var parametro = new
                    {
                        CD_USUARIO = usuarioComTelefone.UsuarioId
                    };
                    var result = connection.Query(selecaoQuery, parametro);
                    return Json(result);
                }

            }
            catch (Exception ex)
            {
                return BadRequest("Ocorreu um erro ao recuperar os usuários: " + ex.Message);
            }
        }
    }
}
