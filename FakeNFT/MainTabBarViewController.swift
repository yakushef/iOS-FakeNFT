import UIKit

//MARK: - временные классы до объединения эпиков
final class StatisticsViewController: UIViewController { }
final class ProfileViewController: UIViewController { }

extension UITabBar {
    open override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        
        let subviewClass = String(describing: type(of: subview))
        if subviewClass == "UIBarBackgroundShadowContentImageView" {
            subview.isHidden = true
        }
    }
}

final class MainTabBarViewController: UITabBarController {
    let statisticVC = UINavigationController(rootViewController: StatisticsViewController())
    let cartVC = UINavigationController(rootViewController: CartViewController())
    let profileVC = UINavigationController(rootViewController: ProfileViewController())
    let catalogVC = UINavigationController(rootViewController: CatalogViewController())
    
    func setupTabBar() {
        tabBar.unselectedItemTintColor = .ypBlack
        tabBar.backgroundColor = .ypWhite
        tabBar.tintColor = .blueUniversal
        tabBar.barTintColor = .ypWhite

        statisticVC.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "Tab_Statistics"),
            selectedImage: nil
        )
        
        cartVC.tabBarItem = UITabBarItem(
            title: NSLocalizedString("cartPage.title", tableName: "CartFlow", comment: "Корзина"),
            image: UIImage(named: "Tab_Cart"),
            selectedImage: nil
        )
        cartVC.tabBarItem.accessibilityIdentifier = "cart_tab"
        
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
        self.selectedIndex = 1
    }
}

