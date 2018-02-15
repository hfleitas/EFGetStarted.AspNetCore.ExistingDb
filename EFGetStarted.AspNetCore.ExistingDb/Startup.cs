using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

#region AddedUsings
using EFGetStarted.AspNetCore.ExistingDb.Models;
using Microsoft.EntityFrameworkCore;
#endregion

namespace EFGetStarted.AspNetCore.ExistingDb
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc();

            //var connection = @"Server=localhost;Database=Blogging;Trusted_Connection=True;ConnectRetryCount=0";
            var connection = @"Data Source = localhost; Database = Blogging; Persist Security Info = True; User ID = core; Password = 'AspNetC0re.ExistingDb'; Pooling = False; MultipleActiveResultSets = False; Encrypt = False; TrustServerCertificate = True";

            //This is for ForceEncryption demo. https://github.com/hfleitas/Pixies.git
            //Use this method if you have the SQL Alias and localhosts entry and TCP Proxy running, p-nat 10101 to 1433.
            //var connection = @"Data Source = Pixies10101,10101; Database = Blogging; Persist Security Info = True; User ID = core; Password = 'AspNetC0re.ExistingDb'; Pooling = False; MultipleActiveResultSets = False; Encrypt = False; TrustServerCertificate = True";
            services.AddDbContext<BloggingContext>(options => options.UseSqlServer(connection));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseBrowserLink();
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
