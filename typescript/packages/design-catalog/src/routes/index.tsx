import { createFileRoute, Link } from "@tanstack/react-router";

export const Route = createFileRoute("/")({
  component: Home,
});

function Home() {
  return (
    <div className="p-8 max-w-2xl mx-auto">
      <h1 className="text-4xl font-bold mb-4">EQMonitor Design Catalog</h1>
      <p className="text-text-secondary mb-8">
        アプリ全体の各種コンポーネントのイメージを調整するためのカタログです。
      </p>

      <nav className="grid grid-cols-1 gap-4">
        <Link
          to="/colors"
          className="p-6 bg-surface-card rounded-card border border-outline-soft hover:border-brand-primary transition-colors flex items-center justify-between"
        >
          <div className="flex items-center">
            <span className="material-icons text-brand-primary mr-4">palette</span>
            <div>
              <div className="font-bold text-lg text-text-primary">Colors</div>
              <div className="text-sm text-text-tertiary">
                Core, Brand, Status, and Text palettes
              </div>
            </div>
          </div>
          <span className="material-icons text-text-tertiary">chevron_right</span>
        </Link>

        <Link
          to="/typography"
          className="p-6 bg-surface-card rounded-card border border-outline-soft hover:border-brand-primary transition-colors flex items-center justify-between"
        >
          <div className="flex items-center">
            <span className="material-icons text-brand-primary mr-4">text_fields</span>
            <div>
              <div className="font-bold text-lg text-text-primary">Typography</div>
              <div className="text-sm text-text-tertiary">Type scales and font families</div>
            </div>
          </div>
          <span className="material-icons text-text-tertiary">chevron_right</span>
        </Link>

        <Link
          to="/components"
          className="p-6 bg-surface-card rounded-card border border-outline-soft hover:border-brand-primary transition-colors flex items-center justify-between"
        >
          <div className="flex items-center">
            <span className="material-icons text-brand-primary mr-4">widgets</span>
            <div>
              <div className="font-bold text-lg text-text-primary">Components</div>
              <div className="text-sm text-text-tertiary">Buttons, Toggles, Cards, and more</div>
            </div>
          </div>
          <span className="material-icons text-text-tertiary">chevron_right</span>
        </Link>
      </nav>
    </div>
  );
}
