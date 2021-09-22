using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using CRUDUsingMVC.Services;
using CRUDUsingMVC.Data;
using Unity;
using Unity.Injection;

namespace CRUDUsingMVC
{
    public class MvcApplication : HttpApplication
    {
        static readonly IUnityContainer container = new UnityContainer();

        protected void Application_Start()
        {
            //container.RegisterType<ICategoryRepository, CategoryRepository>(new InjectionConstructor());
            //container.RegisterType<IProductRepository, ProductRepository>(new InjectionConstructor());

            container.RegisterType<ICategoryService, CategoryService>(new InjectionConstructor());

            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }
    }
}
