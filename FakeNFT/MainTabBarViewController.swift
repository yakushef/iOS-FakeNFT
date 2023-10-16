import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statisticVC = UINavigationController(rootViewController: StatisticsViewController())
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        statisticVC.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(systemName: "flag.2.crossed.fill"),
            selectedImage: nil
        )
        
        setViewControllers([statisticVC], animated: true)
    }
}

