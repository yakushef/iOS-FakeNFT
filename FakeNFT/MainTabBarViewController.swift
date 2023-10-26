import UIKit

//MARK: - временные классы до объединения эпиков
final class StatisticsViewController: UIViewController { }
final class ProfileViewController: UIViewController { }
final class CatalogViewController: UIViewController { }

final class MainTabBarViewController: UITabBarController {
    let statisticVC = UINavigationController(rootViewController: StatisticsViewController())
    let cartVC = UINavigationController(rootViewController: CartViewController())
    let profileVC = UINavigationController(rootViewController: ProfileViewController())
    let catalogVC = UINavigationController(rootViewController: CatalogViewController())
    
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        appearance.selectionIndicatorTintColor = .blueUniversal
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        statisticVC.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "Tab_Statistics"),
            selectedImage: nil
        )
        cartVC.tabBarItem = UITabBarItem(
            title: "Корзина",
            image: UIImage(named: "Tab_Cart"),
            selectedImage: nil
        )
        profileVC.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(named: "Tab_Profile"),
            selectedImage: nil
        )
        catalogVC.tabBarItem = UITabBarItem(
            title: "Каталог",
            image: UIImage(named: "Tab_Catalog"),
            selectedImage: nil
        )
        
        setViewControllers([profileVC, catalogVC, cartVC, statisticVC], animated: true)
    }
}

