# Easy Components

Easy Components is a project designed to boost productivity by providing reusable components commonly used in company projects. It allows you to quickly set up elements like a header with a logo and menu, which transforms into a hamburger menu on mobile, among other components.

## Project Structure

```less
easy-components
├── README.md
├── node_modules
├── package.json
├── pnpm-lock.yaml
├── scripts
│   └── build.sh
├── src
│   ├── components
│   │   ├── header
│   │   │   ├── header.css
│   │   │   ├── header.html
│   │   │   ├── header.js
│   │   └── ...
│   ├── index.html
│   └── input.css
└── tailwind.config.js
```

## Installation

1. Clone the repository:

```bash
git clone git@github.com:V1ctorW1ll1an/easy-components.git
```

2. Install dependencies:

```bash
npm install -g pnpm
cd easy-components
pnpm install
```

## Usage

### Running the Development Server

To start a development server and view the components, run:

```bash
pnpm run dev
```

### Compiling and Watching CSS

This project uses Tailwind CSS for styling the components. The build.sh script helps automate the process of compiling styles. Before running it, you need to grant execution permission to the file:

```bash
chmod +x ./scripts/build.sh
```

### Script Options

1. Generate Minified CSS for a Specific Component:

```bash
pnpm run tailwind:minify [component]
```

Example:

```bash
pnpm run tailwind:minify header
```

2. Watch for Changes and Automatically Recompile CSS:

```bash
pnpm run tailwind:watch [component]
```

Example:

```bash
pnpm run tailwind:watch header
```

3. Generate Minified CSS for All Components:

```bash
pnpm run tailwind:minify:all
```

The build.sh script supports the following file extensions: html, js. It will look for files with these extensions in each component directory to generate the CSS.

## Available Components:

<ul>
  <li>
    Header: A header with a logo and menu, transforming into a hamburger menu on mobile.
  </li>
</ul>

Each component has its own style files (.css), HTML structure (.html), and JavaScript scripts (.js).

## Contribution

Feel free to contribute new components or improvements to existing ones. To do so, follow the standard contribution steps:

1. Fork the project.
2. Create a branch for your feature (git checkout -b feature/feature-name).
3. Commit your changes (git commit -m 'type: :icon: <header> <description>').
4. Push to the branch (git push origin feature/feature-name).
5. Open a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/V1ctorW1ll1an/easy-components/blob/main/LICENSE) file for more details.
