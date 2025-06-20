<script>
    let { children } = $props();
    import Icon from "@iconify/svelte";
    import "../app.css";

    window.document.getElementsByTagName("html").item(0)?.setAttribute("data-theme", "comdark");
</script>

{@render children()}

<style lang="postcss">
    @reference "../app.css";
    :global(body) {
        @apply bg-base-300 w-full h-screen;
    }
</style>
