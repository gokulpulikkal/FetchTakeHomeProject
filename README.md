# FetchTakeHomeProject

### Summary:
This project is a single-view iOS application developed as part of the Fetch take-home assignment. The app displays a list of recipes fetched from a specified API endpoint. To enhance performance and user experience, a custom LazyImageView component has been implemented. This component efficiently loads and displays images asynchronously, caching them on disk for the duration of the session. The cache is automatically cleared when the app enters the background, ensuring optimal resource management.

https://github.com/user-attachments/assets/bb80d76a-32a0-4548-b84a-aa3bfe46a958


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
- LazyImage Implementation and System Optimization: A significant focus was placed on the implementation of the LazyImageView to ensure efficient resource management, particularly for the list screen displaying a large number of items. The goal was to optimize image loading and caching to minimize memory usage and improve performance, ensuring a smooth user experience. This involved careful handling of asynchronous image loading, disk caching, and cache clearing when the app enters the background.
- Comprehensive Testing: Testing was a key priority throughout the development process. Extensive unit tests were written to cover as many modules as possible, ensuring the reliability of the codebase. By prioritizing test coverage, the goal was to minimize potential issues and maintain a high standard of code quality.
- Modularization and Scalability: Another area of focus was modularization. The codebase was structured into distinct packages to improve readability, maintainability, and scalability. While the current project size does not yield significant build-time improvements, this approach demonstrates the importance of modular architecture in larger-scale applications. By emphasizing modular design, the project highlights best practices for organizing code in a way that supports future growth and collaboration.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
- I did spend arround 16hrs on this project.
- I followed test driven development approach. Significant amount time I spend on writing tests for each of the module to ensure the logic I'm writing is reliable and correct.
- A considerable amount of time was allocated to researching existing implementations and best practices for image caching, particularly referencing community resources like Nuke. This research informed the design and implementation of the custom LazyImageView, ensuring it was both efficient and scalable.
- I also did spend some time for optimization. I had to make some changes to the existing implementations because I found some optimisation issues.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
- One significant trade-off made during the development of this project was related to the LazyImage component. Due to time constraints, a key feature was not implemented. The current implementation of LazyImage does not account for scenarios where disk space is critically low. While the component handles this edge case by not saving images to the cache when space is insufficient, a more robust solution would have involved implementing a Least Recently Used (LRU) eviction policy.
- Another significant trade-off made during the development of this project was related to the user interface (UI) design. Because of the time constraints, I chose to prioritize delivering a robust and functional application over investing additional time in UI enhancements.

### Weakest Part of the Project: What do you think is the weakest part of your project?
- The weakest part would be the design of Image caching system. In my openion a more robust system could have been implemented for this by using proper eviction logic for the cache.
