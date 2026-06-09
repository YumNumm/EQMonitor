import { createFileRoute, Link } from "@tanstack/react-router";

export const Route = createFileRoute("/colors")({
  component: Colors,
});

const corePalette = [
  { name: "background.default", hex: "#0F141A", class: "bg-background-default" },
  { name: "background.subtle", hex: "#131A21", class: "bg-background-subtle" },
  { name: "surface.default", hex: "#171E26", class: "bg-surface-default" },
  { name: "surface.raised", hex: "#1D2630", class: "bg-surface-raised" },
  { name: "surface.card", hex: "#232D38", class: "bg-surface-card" },
  { name: "surface.emphasis", hex: "#2B3744", class: "bg-surface-emphasis" },
  { name: "outline.soft", hex: "#3A4654", class: "bg-outline-soft" },
  { name: "outline.strong", hex: "#506073", class: "bg-outline-strong" },
];

const brandPalette = [
  { name: "brand.primary", hex: "#4D8DFF", class: "bg-brand-primary" },
  { name: "brand.primaryContainer", hex: "#24344A", class: "bg-brand-primaryContainer" },
  { name: "brand.secondary", hex: "#8FB7FF", class: "bg-brand-secondary" },
  { name: "brand.tertiary", hex: "#91D4C8", class: "bg-brand-tertiary" },
];

const statusPalette = [
  { name: "status.success", hex: "#63D39B", class: "bg-status-success" },
  { name: "status.warning", hex: "#F4C75E", class: "bg-status-warning" },
  { name: "status.danger", hex: "#FF7A7A", class: "bg-status-danger" },
  { name: "status.info", hex: "#78B8FF", class: "bg-status-info" },
];

const textPalette = [
  {
    name: "text.primary",
    hex: "#F3F6FA",
    class: "bg-text-primary",
    textClass: "text-text-inverse",
  },
  {
    name: "text.secondary",
    hex: "#C4CCD7",
    class: "bg-text-secondary",
    textClass: "text-text-inverse",
  },
  {
    name: "text.tertiary",
    hex: "#98A5B5",
    class: "bg-text-tertiary",
    textClass: "text-text-inverse",
  },
  {
    name: "text.inverse",
    hex: "#0F141A",
    class: "bg-text-inverse",
    textClass: "text-text-primary",
  },
];

function ColorSwatch({
  name,
  hex,
  className,
  textClass = "text-text-primary",
}: {
  name: string;
  hex: string;
  className: string;
  textClass?: string;
}) {
  return (
    <div className="flex flex-col space-y-2">
      <div
        className={`h-24 w-full rounded-card ${className} border border-outline-soft flex items-center justify-center`}
      >
        <span className={`font-mono text-sm ${textClass}`}>{hex}</span>
      </div>
      <div className="flex flex-col">
        <span className="text-sm font-medium">{name}</span>
      </div>
    </div>
  );
}

function Colors() {
  return (
    <div className="p-8 max-w-6xl mx-auto">
      <header className="mb-12">
        <Link to="/" className="text-brand-primary hover:underline flex items-center mb-4">
          <span className="material-icons mr-1">arrow_back</span> Back to Home
        </Link>
        <h1 className="text-4xl font-bold">Colors</h1>
      </header>

      <section className="mb-12">
        <h2 className="text-2xl font-semibold mb-6">Core Palette</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          {corePalette.map((color) => (
            <ColorSwatch
              key={color.name}
              name={color.name}
              hex={color.hex}
              className={color.class}
            />
          ))}
        </div>
      </section>

      <section className="mb-12">
        <h2 className="text-2xl font-semibold mb-6">Brand Colors</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          {brandPalette.map((color) => (
            <ColorSwatch
              key={color.name}
              name={color.name}
              hex={color.hex}
              className={color.class}
            />
          ))}
        </div>
      </section>

      <section className="mb-12">
        <h2 className="text-2xl font-semibold mb-6">Status Colors</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          {statusPalette.map((color) => (
            <ColorSwatch
              key={color.name}
              name={color.name}
              hex={color.hex}
              className={color.class}
            />
          ))}
        </div>
      </section>

      <section className="mb-12">
        <h2 className="text-2xl font-semibold mb-6">Text Colors</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          {textPalette.map((color) => (
            <ColorSwatch
              key={color.name}
              name={color.name}
              hex={color.hex}
              className={color.class}
              textClass={color.textClass}
            />
          ))}
        </div>
      </section>
    </div>
  );
}
