using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace formulario_dp
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            int ban = 1;
            String id = txtId.Text;
            String nombre = txtNombre.Text;
            String apellido_p = txtApellidoPaterno.Text;
            String apellido_m = txtApellidoMaterno.Text;
            String calle = txtCalle.Text;
            String numero = txtNumero.Text;
            String colonia = txtColonia.Text;

            //String sql = "INSERT INTO persons (Nombre,Apellido_Paterno,Apellido_Materno) VALUES ('" + nombre + "','" + apellido_p + "','" + apellido_m + "')";
            String sql = "CALL GUARDAR_DISTRIBUIDOR('" + ban + "','" + id + "','" + nombre + "','" + apellido_p + "','" + apellido_m + "','" + calle + "','" + numero + "','" + colonia + "')";

            MySqlConnection conexionBD = Conexion.conexion();
            conexionBD.Open();

            try
            {
                MySqlCommand comando = new MySqlCommand(sql, conexionBD);
                comando.ExecuteNonQuery();

                MessageBox.Show("Registro guardado");

                limpiar();

                txtId.Focus();
            }
            catch (MySqlException ex)
            {
                MessageBox.Show("Error al guardar: " + ex.Message);
            }
            finally 
            {
                conexionBD.Close(); 
            }
;
        }

        private void btnConsultar_Click(object sender, EventArgs e)
        {
            int ban = 1;
            String id = txtId.Text;

            MySqlDataReader reader = null; //contenedor

            String sql = "CALL OBTENER_DISTRIBUIDOR('"+ban+"','"+id+"')";

            MySqlConnection conexionBD = Conexion.conexion();
            conexionBD.Open();

            try
            {
                MySqlCommand comando = new MySqlCommand(sql, conexionBD);
                reader = comando.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        txtId.Text = reader.GetString(0);
                        txtNombre.Text = reader.GetString(1);
                        txtApellidoPaterno.Text = reader.GetString(2);
                        txtApellidoMaterno.Text = reader.GetString(3);
                        txtCalle.Text = reader.GetString(4);
                        txtNumero.Text = reader.GetString(5);
                        txtColonia.Text = reader.GetString(6);
                    }
                }
                else
                {
                    MessageBox.Show("No se encontro el registro");
                }
            }
            catch (MySqlException ex)
            {
                MessageBox.Show("Error al buscar: " + ex.Message);
            }
            finally
            {
                conexionBD.Close();
            }

        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();

            txtId.Focus();
        }

        private void limpiar()
        {
            txtId.Text = "";
            txtNombre.Text = "";
            txtApellidoPaterno.Text = "";
            txtApellidoMaterno.Text = "";
            txtCalle.Text = "";
            txtNumero.Text = "";
            txtColonia.Text = "";
        }
    }
}
