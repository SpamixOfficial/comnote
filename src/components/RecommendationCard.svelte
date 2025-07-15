<script lang="ts">
    import Icon from "@iconify/svelte";
    import type { AnimeSummary } from "../lib/models";

    type Props = {
        theme: string;
        card_data: AnimeSummary;
    };

    const { theme = $bindable(), card_data }: Props = $props();
    let image_loaded = $state(false);
    $inspect(card_data);
</script>

<!-- Main Box -->
<div
    class="bg-base-200 flex justify-start items-start gap-5 px-5 py-4 rounded-3xl w-full h-fit shadow-[0px_8px_4px_0px_rgba(0,0,0,0.51)]"
>
    <div
        class="min-w-25 min-h-41 bg-white/0 rounded-2xl shadow-[0px_4px_4px_0px_rgba(0,0,0,0.50)] outline-4 outline-base-300 overflow-hidden"
    >
        {#if !image_loaded}
            <span class="absolute loading loading-ring loading-xs"></span>
        {/if}
        <!-- svelte-ignore a11y_img_redundant_alt -->
        <img
            class="w-25 h-41 object-cover"
            onload={() => {
                image_loaded = true;
            }}
            src={card_data.main_picture.large}
            alt="Poster image"
        />
    </div>

    <div
        class="max-h-41 w-full self-stretch p-3.5 bg-base-300 rounded-2xl shadow-[0px_4px_4px_0px_rgba(0,0,0,0.50)] inline-flex flex-col justify-start items-start gap-2.5"
    >
        <div
            class="self-stretch h-60 p-5 bg-neutral rounded-2xl shadow-[0px_4px_4px_0px_rgba(0,0,0,0.25)] flex flex-col justify-between items-start overflow-hidden"
        >
            <div
                class="justify-start text-neutral-content text-xl font-bold font-['Helvetica'] [text-shadow:_0px_4px_4px_rgb(0_0_0_/_0.25)]"
            >
                {card_data.title}
            </div>
            <div class="self-stretch h-1 bg-base-300 rounded-[30px]">
                &nbsp;
            </div>
            <div
                class="self-stretch max-w-full justify-start text-neutral-content text-base font-light font-['Helvetica'] text-ellipsis"
            >
                {card_data.synopsis}
            </div>
        </div>
        <div
            class="w-full h-20 p-[5px] left-[15px] top-[269px] inline-flex justify-start items-end gap-5"
        >
            <div
                class="w-full self-stretch inline-flex flex-col justify-between items-center"
            >
                {#if card_data.rank}
                    <div
                        class="self-stretch bg-neutral rounded-[10px] shadow-[0px_4px_4px_0px_rgba(0,0,0,0.30)] outline-1 outline-offset-[-1px] outline-stone-50 inline-flex justify-center items-center gap-2.5"
                    >
                        <div class="w-7 h-7 relative overflow-hidden">
                            <div
                                class="w-6 h-6 left-[3.75px] top-[3.75px] bg-stone-50"
                            ></div>
                        </div>
                        <div
                            class="text-center justify-start text-stone-50 text-2xl font-bold font-['Helvetica']"
                        >
                            #{card_data.rank}
                        </div>
                    </div>
                {/if}
                <div
                    class="self-stretch bg-neutral rounded-[10px] shadow-[0px_4px_4px_0px_rgba(0,0,0,0.30)] outline-1 outline-offset-[-1px] outline-stone-50 inline-flex justify-center items-center gap-2.5"
                >
                    <div class="w-7 h-7 relative overflow-hidden">
                        <div class="w-7 h-7 left-0 top-0 absolute"></div>
                        <div
                            class="w-6 h-5 left-[3.50px] top-[5px] absolute bg-stone-50"
                        ></div>
                    </div>
                    <div
                        class="text-center justify-start text-stone-50 text-2xl font-bold font-['Helvetica']"
                    >
                        #{card_data.popularity}
                    </div>
                </div>
            </div>
            <div
                class="h-10 w-fit p-4 bg-neutral rounded-[10px] shadow-[0px_0px_9px_0px] shadow-error outline-2 outline-offset-[-2px] outline-error flex justify-center items-center gap-2.5"
            >
                <div
                    class="flex flex-row justify-start items-start text-error text-2xl font-bold font-['Helvetica'] [text-shadow:_0px_0px_4px] text-shadow-error"
                >
                    <Icon icon="ic:outline-star" width="30" height="30" /> 3.49
                </div>
            </div>
            <button
                class="btn btn-lg h-10 btn-primary shadow-lg shadow-primary/50 font-bold text-primary-content [text-shadow:_0px_4px_4px_rgb(0_0_0_/_0.30)]"
                >Open <Icon
                    icon="mdi:arrow-right-thin"
                    width="24"
                    height="24"
                /></button
            >
        </div>
    </div>
</div>
