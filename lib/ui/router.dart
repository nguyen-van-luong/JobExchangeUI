
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/dtos/jwt_payload.dart';
import 'package:untitled1/ui/views/CV/cv_view.dart';
import 'package:untitled1/ui/views/admin/admin_view.dart';
import 'package:untitled1/ui/views/cv_detail/cv_detail_view.dart';
import 'package:untitled1/ui/views/employer/employer_view.dart';
import 'package:untitled1/ui/views/employer_detail/employer_detail_view.dart';
import 'package:untitled1/ui/views/employers/employers_view.dart';
import 'package:untitled1/ui/views/home/home_view.dart';
import 'package:untitled1/ui/views/job/job_view.dart';
import 'package:untitled1/ui/views/job_detail/job_detail_view.dart';
import 'package:untitled1/ui/views/login/login_view.dart';
import 'package:untitled1/ui/views/logout/logout_view.dart';
import 'package:untitled1/ui/views/register/register_employer_view.dart';
import 'package:untitled1/ui/views/register/register_student_view.dart';
import 'package:untitled1/ui/views/student/student_view.dart';
import 'package:untitled1/ui/views/student/widget/bookmark/bookmark_view.dart';
import 'package:untitled1/ui/views/student_detail/student_detail_view.dart';
import 'package:untitled1/ui/views/students/students_view.dart';
import 'package:untitled1/ui/widgets/screen_with_header_and_footer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class NavigationDestination {
  const NavigationDestination({
    required this.route,
    required this.label,
    required this.icon,
    this.child,
  });

  final String route;
  final String label;
  final Icon icon;
  final Widget? child;
}

final appRouter = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: const ValueKey('home'),
        child: ScreenWithHeaderAndFooter(
          body: HomeView(),
        ),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('login'),
        child: LoginView(),
      ),
    ),
    GoRoute(
      path: '/logout',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('logout'),
        child: LogoutView(),
      ),
    ),
    GoRoute(
      path: '/register_student',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('register_student'),
        child: RegisterStudentView(),
      ),
    ),
    GoRoute(
      path: '/register_employer',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('register_employer'),
        child: RegisterEmployerView(),
      ),
    ),
    GoRoute(
      path: '/cu_job',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: const ValueKey("cu_job"),
            child: ScreenWithHeaderAndFooter(
              body: EmployerView(
                indexSelected: 1,
                params: convertQuery(query: ""),
              )
            ));
      },
      redirect: EmployerMiddleware().redirect,
    ),
    GoRoute(
      path: '/cu_job/:query',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: const ValueKey("cu_job"),
            child: ScreenWithHeaderAndFooter(
                body: EmployerView(
                  indexSelected: 1,
                  params: convertQuery(query: state.pathParameters["query"] ?? ""),
                )
            ));
      },
      redirect: EmployerMiddleware().redirect,
    ),
    GoRoute(
      path: '/viewsearch',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('viewsearch'),
        child: ScreenWithHeaderAndFooter(
          body: JobView(params: {}),
        ),
      ),),
    GoRoute(
        path: '/viewsearch/:query',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('viewsearch'),
              child: ScreenWithHeaderAndFooter(
                body: JobView(
                    params: convertQuery(
                        query: state.pathParameters["query"] ?? ""),
                ),
              ));
        }),
    GoRoute(
      path: '/cu_cv',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: const ValueKey("student_cv"),
            child: ScreenWithHeaderAndFooter(
                body: StudentView(
                  indexSelected: 1,
                  params: convertQuery(query: ""),
                )
            ));
      },
      redirect: StudentMiddleware().redirect,
    ),
    GoRoute(
      path: '/cu_cv/:query',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: const ValueKey("student_cv"),
            child: ScreenWithHeaderAndFooter(
                body: StudentView(
                  indexSelected: 1,
                  params: convertQuery(query: state.pathParameters["query"] ?? ""),
                )
            ));
      },
      redirect: StudentMiddleware().redirect,
    ),
    GoRoute(
      path: '/cv/viewsearch',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('cv_viewsearch'),
        child: ScreenWithHeaderAndFooter(
          body: CVView(params: {}),
        ),
      ),),
    GoRoute(
        path: '/cv/viewsearch/:query',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('cv_viewsearch'),
              child: ScreenWithHeaderAndFooter(
                body: CVView(
                  params: convertQuery(
                      query: state.pathParameters["query"] ?? ""),
                ),
              ));
        }),
    GoRoute(
        path: '/job/:pid',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('job_detail'),
              child: ScreenWithHeaderAndFooter(
                body: JobDetailView(id: state.pathParameters['pid']!)
              ));
        }),
    GoRoute(
      path: '/application',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('application'),
        child: ScreenWithHeaderAndFooter(
          body: EmployerView(indexSelected: 3,params: {}),
        ),
      ),
      redirect: EmployerMiddleware().redirect,
    ),
    GoRoute(
      path: '/application/:query',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: ValueKey('application'),
            child: ScreenWithHeaderAndFooter(
              body: EmployerView(
                indexSelected: 3,
                params: convertQuery(
                    query: state.pathParameters["query"] ?? ""),
              ),
            ));
      },
      redirect: EmployerMiddleware().redirect,
    ),
    GoRoute(
        path: '/cv/:pid',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('cv_detail'),
              child: ScreenWithHeaderAndFooter(
                  body: CVDetailView(id: state.pathParameters['pid']!)
              ));
        }),
    GoRoute(
        path: '/employer/:pid',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('employer_detail'),
              child: ScreenWithHeaderAndFooter(
                  body: EmployerDetailView(id: state.pathParameters['pid']!, params: {})
              ));
        }),
    GoRoute(
        path: '/employer/:pid/:query',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('employer_detail'),
              child: ScreenWithHeaderAndFooter(
                  body: EmployerDetailView(
                    id: state.pathParameters['pid']!,
                    params: convertQuery(
                        query: state.pathParameters["query"] ?? ""),
                  )
              ));
        }),
    GoRoute(
        path: '/student/:pid',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('student_detail'),
              child: ScreenWithHeaderAndFooter(
                  body: StudentDetailView(
                    id: state.pathParameters['pid']!,
                    params: {}
                  )
              ));
        }),
    GoRoute(
        path: '/student/:pid/:query',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('student_detail'),
              child: ScreenWithHeaderAndFooter(
                  body: StudentDetailView(
                    id: state.pathParameters['pid']!,
                    params: convertQuery(
                        query: state.pathParameters["query"] ?? ""),
                  )
              ));
        }),
    GoRoute(
      path: '/studentBookmark',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: ValueKey('studentBookmark'),
            child: ScreenWithHeaderAndFooter(
                body: StudentView(
                  indexSelected: 3,
                  params: {}
                )
            ));
      },
      redirect: StudentMiddleware().redirect,
    ),
    GoRoute(
      path: '/studentBookmark/:query',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: ValueKey('studentBookmark'),
            child: ScreenWithHeaderAndFooter(
                body: StudentView(
                  indexSelected: 3,
                  params: convertQuery(
                      query: state.pathParameters["query"] ?? ""),
                )
            ));
      },
      redirect: StudentMiddleware().redirect,
    ),
    GoRoute(
      path: '/studentFollow',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: ValueKey('studentFollow'),
            child: ScreenWithHeaderAndFooter(
                body: StudentView(
                    indexSelected: 4,
                    params: {}
                )
            ));
      },
      redirect: StudentMiddleware().redirect,
    ),
    GoRoute(
      path: '/studentFollow/:query',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: ValueKey('studentFollow'),
            child: ScreenWithHeaderAndFooter(
                body: StudentView(
                  indexSelected: 4,
                  params: convertQuery(
                      query: state.pathParameters["query"] ?? ""),
                )
            ));
      },
      redirect: StudentMiddleware().redirect,
    ),
    GoRoute(
      path: '/job_manage',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('job_manage'),
        child: ScreenWithHeaderAndFooter(
          body: EmployerView(indexSelected: 2,params: {}),
        ),
      ),
      redirect: EmployerMiddleware().redirect,
    ),
    GoRoute(
      path: '/job_manage/:query',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: ValueKey('job_manage'),
            child: ScreenWithHeaderAndFooter(
              body: EmployerView(
                indexSelected: 2,
                params: convertQuery(
                    query: state.pathParameters["query"] ?? ""),
              ),
            ));
      },
      redirect: EmployerMiddleware().redirect,
    ),
    GoRoute(
      path: '/cv_manage',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('cv_manage'),
        child: ScreenWithHeaderAndFooter(
          body: StudentView(indexSelected: 2,params: {}),
        ),
      ),
      redirect: StudentMiddleware().redirect,
    ),
    GoRoute(
      path: '/cv_manage/:query',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: ValueKey('cv_manage'),
            child: ScreenWithHeaderAndFooter(
              body: StudentView(
                indexSelected: 2,
                params: convertQuery(
                    query: state.pathParameters["query"] ?? ""),
              ),
            ));
      },
      redirect: StudentMiddleware().redirect,
    ),
    GoRoute(
      path: '/student_manage',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('student_manage'),
        child: ScreenWithHeaderAndFooter(
          body: StudentView(indexSelected: 0,params: {}),
        ),
      ),
      redirect: StudentMiddleware().redirect,
    ),

    GoRoute(
      path: '/employer_manage',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('employer_manage'),
        child: ScreenWithHeaderAndFooter(
          body: EmployerView(indexSelected: 0,params: {}),
        ),
      ),
      redirect: EmployerMiddleware().redirect,
    ),

    GoRoute(
      path: '/industry_manage',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('industry_manage'),
        child: ScreenWithHeaderAndFooter(
          body: AdminView(indexSelected: 1,params: {}),
        ),
      ),),
    GoRoute(
        path: '/industry_manage/:query',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('industry_manage'),
              child: ScreenWithHeaderAndFooter(
                body: AdminView(
                  indexSelected: 1,
                  params: convertQuery(
                      query: state.pathParameters["query"] ?? ""),
                ),
              ));
        }),
    GoRoute(
      path: '/search_student',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('search_student'),
        child: ScreenWithHeaderAndFooter(
          body: StudentsView(params: {}),
        ),
      ),),
    GoRoute(
        path: '/search_student/:query',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('search_student'),
              child: ScreenWithHeaderAndFooter(
                body: StudentsView(
                  params: convertQuery(
                      query: state.pathParameters["query"] ?? ""),
                ),
              ));
        }),
    GoRoute(
      path: '/search_employer',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('search_employer'),
        child: ScreenWithHeaderAndFooter(
          body: EmployersView(params: {}),
        ),
      ),),
    GoRoute(
        path: '/search_employer/:query',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
              key: ValueKey('search_employer'),
              child: ScreenWithHeaderAndFooter(
                body: EmployersView(
                  params: convertQuery(
                      query: state.pathParameters["query"] ?? ""),
                ),
              ));
        }),
    GoRoute(
      path: '/employer_notification',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('employer_notification'),
        child: ScreenWithHeaderAndFooter(
          body: EmployerView(indexSelected: 4,params: {}),
        ),
      ),
      redirect: EmployerMiddleware().redirect,
    ),
    GoRoute(
      path: '/employer_notification/:query',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: ValueKey('employer_notification'),
            child: ScreenWithHeaderAndFooter(
              body: EmployerView(
                indexSelected: 4,
                params: convertQuery(
                    query: state.pathParameters["query"] ?? ""),
              ),
            ));
      },
      redirect: EmployerMiddleware().redirect,
    ),
    GoRoute(
      path: '/student_notification',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: ValueKey('student_notification'),
        child: ScreenWithHeaderAndFooter(
          body: StudentView(indexSelected: 5,params: {}),
        ),
      ),
      redirect: StudentMiddleware().redirect,
    ),
    GoRoute(
      path: '/student_notification/:query',
      pageBuilder: (context, state) {
        return MaterialPage<void>(
            key: ValueKey('student_notification'),
            child: ScreenWithHeaderAndFooter(
              body: StudentView(
                indexSelected: 5,
                params: convertQuery(
                    query: state.pathParameters["query"] ?? ""),
              ),
            ));
      },
      redirect: StudentMiddleware().redirect,
    ),
  ],

);
Map<String, String> convertQuery({required String query}) {
  Map<String, String> params = {};
  query.split("&").forEach((param) {
    List<String> keyValue = param.split("=");
    if (keyValue.length == 2) {
      params[keyValue[0]] = keyValue[1];
    }
  });
  return params;
}

class StudentMiddleware {
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (JwtPayload.role == "ROLE_student") {
      // If not, redirect to the login page.
      return null;
    }
    // If the user is logged in, continue with the navigation.
    return '/login';
  }
}

class EmployerMiddleware {
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (JwtPayload.role == "ROLE_employer") {
      // If not, redirect to the login page.
      return null;
    }
    // If the user is logged in, continue with the navigation.
    return '/login';
  }
}