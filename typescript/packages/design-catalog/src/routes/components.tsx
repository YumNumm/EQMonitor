import { createFileRoute, Link } from "@tanstack/react-router";
import { useState } from "react";

export const Route = createFileRoute("/components")({
  component: Components,
});

function Button({
  children,
  variant = "primary",
  icon,
}: {
  children: React.ReactNode;
  variant?: "primary" | "tonal" | "outlined" | "text";
  icon?: string;
}) {
  const baseStyles =
    "inline-flex items-center justify-center px-6 py-2.5 rounded-button font-medium text-sm transition-all duration-150 active:scale-95";

  const variants = {
    primary: "bg-brand-primary text-text-inverse hover:opacity-90",
    tonal: "bg-brand-primary-container text-brand-secondary hover:bg-opacity-80",
    outlined:
      "border border-outline-strong text-brand-primary hover:bg-brand-primary hover:bg-opacity-10",
    text: "text-brand-primary hover:bg-brand-primary hover:bg-opacity-10",
  };

  return (
    <button className={`${baseStyles} ${variants[variant]}`}>
      {icon && <span className="material-icons text-[18px] mr-2">{icon}</span>}
      {children}
    </button>
  );
}

function AppSwitch({
  label,
  description,
  checked,
  onChange,
}: {
  label: string;
  description?: string;
  checked: boolean;
  onChange: (val: boolean) => void;
}) {
  return (
    <div className="flex items-center justify-between py-3">
      <div className="flex flex-col">
        <span className="text-titleSmall">{label}</span>
        {description && <span className="text-bodySmall text-text-secondary">{description}</span>}
      </div>
      <button
        onClick={() => onChange(!checked)}
        className={`relative w-12 h-7 rounded-full transition-colors duration-200 focus:outline-none ${checked ? "bg-brand-primary" : "bg-surface-emphasis"}`}
      >
        <div
          className={`absolute top-1 left-1 w-5 h-5 bg-white rounded-full transition-transform duration-200 flex items-center justify-center ${checked ? "translate-x-5" : "translate-x-0"}`}
        >
          <span className="material-icons text-[14px] text-background-default">
            {checked ? "check" : "close"}
          </span>
        </div>
      </button>
    </div>
  );
}

function ListTile({
  title,
  subtitle,
  trailing,
  leadingIcon,
}: {
  title: string;
  subtitle?: string;
  trailing?: React.ReactNode;
  leadingIcon?: string;
}) {
  return (
    <div className="flex items-center px-4 py-3 hover:bg-surface-emphasis transition-colors cursor-pointer rounded-lg">
      {leadingIcon && (
        <div className="mr-4 w-10 h-10 rounded-full bg-surface-raised flex items-center justify-center">
          <span className="material-icons text-text-secondary">{leadingIcon}</span>
        </div>
      )}
      <div className="flex-1 flex flex-col">
        <span className="text-titleSmall">{title}</span>
        {subtitle && <span className="text-bodySmall text-text-secondary">{subtitle}</span>}
      </div>
      {trailing && <div className="ml-4">{trailing}</div>}
    </div>
  );
}

function SegmentedButton({
  options,
  value,
  onChange,
}: {
  options: string[];
  value: string;
  onChange: (val: string) => void;
}) {
  return (
    <div className="flex bg-surface-raised p-1 rounded-full border border-outline-soft">
      {options.map((opt) => (
        <button
          key={opt}
          onClick={() => onChange(opt)}
          className={`px-4 py-1.5 rounded-full text-sm font-medium transition-all ${
            value === opt
              ? "bg-brand-primary text-text-inverse"
              : "text-text-secondary hover:text-text-primary"
          }`}
        >
          {opt}
        </button>
      ))}
    </div>
  );
}

function Skeleton({ className }: { className?: string }) {
  return <div className={`animate-pulse bg-surface-emphasis rounded ${className}`}></div>;
}

function Components() {
  const [switch1, setSwitch1] = useState(true);
  const [switch2, setSwitch2] = useState(false);
  const [segment, setSegment] = useState("Option 1");

  return (
    <div className="p-8 max-w-6xl mx-auto">
      <header className="mb-12">
        <Link to="/" className="text-brand-primary hover:underline flex items-center mb-4">
          <span className="material-icons mr-1">arrow_back</span> Back to Home
        </Link>
        <h1 className="text-4xl font-bold">Components</h1>
      </header>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
        {/* Buttons */}
        <section className="bg-surface-default p-8 rounded-card border border-outline-soft">
          <h2 className="text-xl font-semibold mb-6">Buttons</h2>
          <div className="flex flex-wrap gap-4">
            <Button variant="primary">Primary</Button>
            <Button variant="tonal">Tonal</Button>
            <Button variant="outlined">Outlined</Button>
            <Button variant="text">Text</Button>
          </div>
          <div className="flex flex-wrap gap-4 mt-6">
            <Button variant="primary" icon="notifications">
              With Icon
            </Button>
            <Button variant="tonal" icon="settings">
              Settings
            </Button>
          </div>
        </section>

        {/* Toggles */}
        <section className="bg-surface-default p-8 rounded-card border border-outline-soft">
          <h2 className="text-xl font-semibold mb-6">Toggles (AppSwitch)</h2>
          <div className="bg-surface-card rounded-xl p-4">
            <AppSwitch
              label="Notification"
              description="Enable push notifications for updates"
              checked={switch1}
              onChange={setSwitch1}
            />
            <div className="border-t border-outline-soft my-1"></div>
            <AppSwitch label="Dark Mode" checked={switch2} onChange={setSwitch2} />
          </div>
        </section>

        {/* ListTiles & Cards */}
        <section className="bg-surface-default p-8 rounded-card border border-outline-soft lg:col-span-2">
          <h2 className="text-xl font-semibold mb-6">ListTiles & Settings Rows</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div className="bg-surface-card rounded-card border border-outline-soft overflow-hidden">
              <ListTile
                title="Account"
                subtitle="Manage your profile and settings"
                leadingIcon="person"
                trailing={<span className="material-icons text-text-tertiary">chevron_right</span>}
              />
              <div className="border-t border-outline-soft"></div>
              <ListTile
                title="Privacy"
                subtitle="Security and app permissions"
                leadingIcon="lock"
                trailing={<span className="material-icons text-text-tertiary">chevron_right</span>}
              />
              <div className="border-t border-outline-soft"></div>
              <ListTile
                title="Help & Support"
                leadingIcon="help"
                trailing={<span className="material-icons text-text-tertiary">chevron_right</span>}
              />
            </div>

            <div className="space-y-6">
              <div className="bg-surface-card p-6 rounded-card border border-outline-soft">
                <h3 className="text-titleMedium mb-4">Segmented Selection</h3>
                <SegmentedButton
                  options={["Option 1", "Option 2", "Option 3"]}
                  value={segment}
                  onChange={setSegment}
                />
              </div>

              <div className="bg-surface-card p-6 rounded-card border border-outline-soft">
                <h3 className="text-titleMedium mb-4">Loading State (Skeleton)</h3>
                <div className="flex items-center space-x-4">
                  <Skeleton className="w-12 h-12 rounded-full" />
                  <div className="flex-1 space-y-2">
                    <Skeleton className="h-4 w-3/4" />
                    <Skeleton className="h-3 w-1/2" />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Informational Card */}
        <section className="bg-surface-default p-8 rounded-card border border-outline-soft lg:col-span-2">
          <h2 className="text-xl font-semibold mb-6">Earthquake Info Card (Example)</h2>
          <div className="bg-surface-card p-6 rounded-card-emphasis border border-outline-strong max-w-md">
            <div className="flex justify-between items-start mb-4">
              <div>
                <span className="bg-status-danger text-text-inverse text-[10px] font-bold px-2 py-0.5 rounded-full uppercase tracking-wider mb-2 inline-block">
                  Emergency
                </span>
                <h3 className="text-headlineSmall">Magnitude 7.4</h3>
              </div>
              <div className="bg-brand-primaryContainer text-brand-secondary p-3 rounded-2xl">
                <span className="text-3xl font-bold font-mono">6+</span>
              </div>
            </div>
            <div className="space-y-1 text-text-secondary">
              <div className="flex items-center">
                <span className="material-icons text-sm mr-2">location_on</span>
                <span className="text-bodyMedium">Offshore of Miyagi Prefecture</span>
              </div>
              <div className="flex items-center">
                <span className="material-icons text-sm mr-2">schedule</span>
                <span className="text-bodyMedium font-mono">2023/10/27 10:45:12</span>
              </div>
            </div>
            <div className="mt-6">
              <Button variant="primary" icon="visibility">
                View Details
              </Button>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}
