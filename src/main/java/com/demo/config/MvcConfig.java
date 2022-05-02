//package com.casic.warehouse.config;
//
//
//import com.casic.warehouse.Interceptor.MyInterceptor;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
//import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
//
///**
// * 拦截器配置
// */
//@Configuration
//public class MvcConfig extends WebMvcConfigurationSupport {
////    以下WebMvcConfigurerAdapter 比较常用的重写接口
////    /** 解决跨域问题 **/
////    public void addCorsMappings(CorsRegistry registry) ;
////    /** 添加拦截器 **/
////    void addInterceptors(InterceptorRegistry registry);
////    /** 这里配置视图解析器 **/
////    void configureViewResolvers(ViewResolverRegistry registry);
////    /** 配置内容裁决的一些选项 **/
////    void configureContentNegotiation(ContentNegotiationConfigurer configurer);
////    /** 视图跳转控制器 **/
////    void addViewControllers(ViewControllerRegistry registry);
////    /** 静态资源处理 **/
////    void addResourceHandlers(ResourceHandlerRegistry registry);
////    /** 默认静态资源处理器 **/
////    void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer);
//
//    @Autowired
//    private MyInterceptor myInterceptor;
//
//    /**
//     *
//     * 功能描述:
//     *  配置静态资源,避免静态资源请求被拦截
//     */
//    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/**")
//                .addResourceLocations("classpath:/");
//        registry.addResourceHandler("/templates/**")
//                .addResourceLocations("classpath:/templates/");
//        super.addResourceHandlers(registry);
//    }
//    //添加拦截器
//    public void addInterceptors(InterceptorRegistry registry) {
//        registry.addInterceptor(myInterceptor)
//                //addPathPatterns 用于添加拦截规则 /**代表拦截所有请求
//                .addPathPatterns("/**")
//                //excludePathPatterns 用于排除拦截 此处我们排除"/"(登录界面)以及"/loginCheck"（验证登录账号密码方法
//                .excludePathPatterns("/")
//                .excludePathPatterns("/loginCheck");
//    }
//}
//
//
