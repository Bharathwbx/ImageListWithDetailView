enum ImageOrientation {
    case portrait
    case landscape
}

struct ImageOrientationCalculator {
    
    static func orientation(width: Int, height: Int) -> ImageOrientation {
        height > width ? .portrait : .landscape
    }
}
