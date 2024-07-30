<!-- component -->
<div class="grid gap-6 mb-8 md:grid-cols-2 xl:grid-cols-3">
    <x-filament::section>
        <div class="min-w-0 rounded-lg shadow-xs overflow-hidden bg-white dark:bg-gray-800 flex justify-between ">
            <div class="p-4 flex items-center">
                <div class="p-3 rounded-full bg-white mr-4">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                        <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                        <g id="SVGRepo_iconCarrier">
                            <path
                                d="M2 9V15.8C2 16.9201 2 17.4802 2.21799 17.908C2.40973 18.2843 2.71569 18.5903 3.09202 18.782C3.51984 19 4.0799 19 5.2 19H13M2 9V8.2C2 7.0799 2 6.51984 2.21799 6.09202C2.40973 5.71569 2.71569 5.40973 3.09202 5.21799C3.51984 5 4.0799 5 5.2 5H13.8C14.9201 5 15.4802 5 15.908 5.21799C16.2843 5.40973 16.5903 5.71569 16.782 6.09202C17 6.51984 17 7.0799 17 8.2V9M2 9H17M17 9V11M5 3V5M14 3V5M17 11C14.2386 11 12 13.2386 12 16C12 18.7614 14.2386 21 17 21C19.7614 21 22 18.7614 22 16C22 13.2386 19.7614 11 17 11ZM17 14V15.5M17 18H17.01"
                                stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                        </g>
                    </svg>
                </div>
                <div>
                    <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                        Upcomming Appointment
                    </p>
                    <p class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                        {{ number_format(0) }}
                    </p>
                </div>
            </div>
        </div>
    </x-filament::section>

    <x-filament::section>
        <div class="min-w-0 rounded-lg shadow-xs overflow-hidden bg-white dark:bg-gray-800 ">
            <div class="p-4 flex items-center">
                <div class="p-3 rounded-full text-blue-500 dark:text-blue-100 bg-blue-100 dark:bg-blue-500 mr-4">
                    <svg fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="w-10 h-10" viewBox="0 0 160 160">
                        <path
                            d="M106.454 32.906v1.816h-2.581v-1.9a11.633 11.633 0 0 1-6.61-3.036l2.043-2.525a9.7 9.7 0 0 0 4.567 2.44V24.17c-3.489-.908-5.844-2.156-5.844-5.5 0-3.064 2.355-5.418 5.844-5.844v-1.73h2.581v1.759a10.557 10.557 0 0 1 5.957 2.637l-1.929 2.61a9.266 9.266 0 0 0-4.028-2.127v5.333c3.887.879 6.468 2.212 6.468 5.673 0 3.259-2.355 5.642-6.468 5.925zm-2.581-12.282v-4.709a2.678 2.678 0 0 0-2.27 2.44c-.003 1.134.739 1.73 2.27 2.269zm5.5 6.694c0-1.3-.907-1.9-2.922-2.5v5.049c1.933-.223 2.925-1.3 2.925-2.549z" />
                        <path
                            d="M105.093 41.258a18.351 18.351 0 1 1 18.35-18.351 18.373 18.373 0 0 1-18.35 18.351zm0-33.2a14.851 14.851 0 1 0 14.85 14.85 14.867 14.867 0 0 0-14.85-14.851zM22.216 123.443H6.307a1.75 1.75 0 0 1-1.75-1.75V89.649a1.751 1.751 0 0 1 1.75-1.75h15.909a1.75 1.75 0 0 1 1.75 1.75v32.044a1.749 1.749 0 0 1-1.75 1.75zm-14.159-3.5h12.409V91.4H8.057zM52.215 123.443H36.306a1.75 1.75 0 0 1-1.75-1.75V78.746A1.75 1.75 0 0 1 36.306 77h15.909a1.749 1.749 0 0 1 1.75 1.75v42.947a1.749 1.749 0 0 1-1.75 1.746zm-14.159-3.5h12.409V80.5H38.056zM82.214 123.443H66.306a1.749 1.749 0 0 1-1.75-1.75v-53.85a1.749 1.749 0 0 1 1.75-1.75h15.908a1.749 1.749 0 0 1 1.75 1.75v53.85a1.749 1.749 0 0 1-1.75 1.75zm-14.158-3.5h12.408v-50.35H68.056zM113.047 123.443H97.138a1.749 1.749 0 0 1-1.75-1.75V64.144h-4.77a1.75 1.75 0 0 1-1.237-2.988l14.474-14.474a1.75 1.75 0 0 1 1.238-.513 1.746 1.746 0 0 1 1.237.513l14.47 14.474a1.75 1.75 0 0 1-1.238 2.988H114.8v57.549a1.749 1.749 0 0 1-1.753 1.75zm-14.159-3.5H111.3V62.394a1.749 1.749 0 0 1 1.75-1.75h2.3l-10.249-10.25-10.25 10.25h2.3a1.75 1.75 0 0 1 1.75 1.75z" />
                    </svg>
                </div>
                <div>
                    <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                        Ongoing Appointment
                    </p>
                    <p class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                        {{ number_format(0) }}
                    </p>
                </div>
            </div>
        </div>
    </x-filament::section>

    <x-filament::section>
        <div class="min-w-0 rounded-lg shadow-xs overflow-hidden bg-white dark:bg-gray-800 ">
            <div class="p-4 flex items-center">
                <div class="p-3 rounded-full bg-red-100 dark:bg-red-300 mr-4">
                    <svg fill="currentColor" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" xml:space="preserve"
                        class="w-10 h-10"
                        style="fill-rule:evenodd;clip-rule:evenodd;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:2">
                        <path d="m37.278 14.519-21.203-2.45a4 4 0 0 0-4.433 3.514l-.763 6.606"
                            style="fill:none;stroke:#222a33;stroke-width:2px" />
                        <path
                            d="m15.001 20.404.322-2.782a1.867 1.867 0 0 1 2.069-1.641l2.976.344M53.202 19.117a4.001 4.001 0 0 0-4.609-3.28l-38.149 6.425a4.001 4.001 0 0 0-3.28 4.609l3.634 21.575a4 4 0 0 0 4.609 3.28l38.149-6.425a4.003 4.003 0 0 0 3.28-4.609l-3.634-21.575z"
                            style="fill:none;stroke:#222a33;stroke-width:2px" />
                        <path
                            d="m19.474 47.253-2.823.476a1.999 1.999 0 0 1-2.305-1.64l-.443-2.632m30.623-23.148 2.823-.475a1.998 1.998 0 0 1 2.305 1.64l.443 2.631m-38.365 6.462-.443-2.632a1.999 1.999 0 0 1 1.64-2.304l2.823-.476M52.268 36.996l.443 2.631a1.999 1.999 0 0 1-1.64 2.305l-2.823.475M33.221 29.788A2.334 2.334 0 1 0 32 33.781a2.336 2.336 0 0 1 2.69 1.914 2.336 2.336 0 0 1-3.911 2.079M31.225 29.177l-.311-1.841M33.086 40.226l-.311-1.841"
                            style="fill:none;stroke:#222a33;stroke-width:2px" />
                    </svg>
                </div>
                <div>
                    <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                        Current Patients
                    </p>
                    <p class="text-lg font-semibold text-gray-700 dark:text-gray-200 ">
                        {{ number_format(0) }}
                    </p>
                </div>
            </div>
        </div>
    </x-filament::section>

</div>


<div class="grid gap-6 mb-8 md:grid-cols-2 xl:grid-cols-3">
    <x-filament::section>
        <div class="min-w-0 rounded-lg shadow-xs overflow-hidden bg-white dark:bg-gray-800 flex justify-between ">
            <div class="p-4 flex items-center">
                <div class="p-3 rounded-full bg-white mr-4">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                        <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                        <g id="SVGRepo_iconCarrier">
                            <path
                                d="M2 9V15.8C2 16.9201 2 17.4802 2.21799 17.908C2.40973 18.2843 2.71569 18.5903 3.09202 18.782C3.51984 19 4.0799 19 5.2 19H13M2 9V8.2C2 7.0799 2 6.51984 2.21799 6.09202C2.40973 5.71569 2.71569 5.40973 3.09202 5.21799C3.51984 5 4.0799 5 5.2 5H13.8C14.9201 5 15.4802 5 15.908 5.21799C16.2843 5.40973 16.5903 5.71569 16.782 6.09202C17 6.51984 17 7.0799 17 8.2V9M2 9H17M17 9V11M5 3V5M14 3V5M17 11C14.2386 11 12 13.2386 12 16C12 18.7614 14.2386 21 17 21C19.7614 21 22 18.7614 22 16C22 13.2386 19.7614 11 17 11ZM17 14V15.5M17 18H17.01"
                                stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                        </g>
                    </svg>
                </div>
                <div>
                    <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                        Upcomming Appointment
                    </p>
                    <p class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                        {{ number_format(0) }}
                    </p>
                </div>
            </div>
        </div>
    </x-filament::section>

    <x-filament::section>
        <div class="min-w-0 rounded-lg shadow-xs overflow-hidden bg-white dark:bg-gray-800 ">
            <div class="p-4 flex items-center">
                <div class="p-3 rounded-full text-blue-500 dark:text-blue-100 bg-blue-100 dark:bg-blue-500 mr-4">
                    <svg fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="w-10 h-10" viewBox="0 0 160 160">
                        <path
                            d="M106.454 32.906v1.816h-2.581v-1.9a11.633 11.633 0 0 1-6.61-3.036l2.043-2.525a9.7 9.7 0 0 0 4.567 2.44V24.17c-3.489-.908-5.844-2.156-5.844-5.5 0-3.064 2.355-5.418 5.844-5.844v-1.73h2.581v1.759a10.557 10.557 0 0 1 5.957 2.637l-1.929 2.61a9.266 9.266 0 0 0-4.028-2.127v5.333c3.887.879 6.468 2.212 6.468 5.673 0 3.259-2.355 5.642-6.468 5.925zm-2.581-12.282v-4.709a2.678 2.678 0 0 0-2.27 2.44c-.003 1.134.739 1.73 2.27 2.269zm5.5 6.694c0-1.3-.907-1.9-2.922-2.5v5.049c1.933-.223 2.925-1.3 2.925-2.549z" />
                        <path
                            d="M105.093 41.258a18.351 18.351 0 1 1 18.35-18.351 18.373 18.373 0 0 1-18.35 18.351zm0-33.2a14.851 14.851 0 1 0 14.85 14.85 14.867 14.867 0 0 0-14.85-14.851zM22.216 123.443H6.307a1.75 1.75 0 0 1-1.75-1.75V89.649a1.751 1.751 0 0 1 1.75-1.75h15.909a1.75 1.75 0 0 1 1.75 1.75v32.044a1.749 1.749 0 0 1-1.75 1.75zm-14.159-3.5h12.409V91.4H8.057zM52.215 123.443H36.306a1.75 1.75 0 0 1-1.75-1.75V78.746A1.75 1.75 0 0 1 36.306 77h15.909a1.749 1.749 0 0 1 1.75 1.75v42.947a1.749 1.749 0 0 1-1.75 1.746zm-14.159-3.5h12.409V80.5H38.056zM82.214 123.443H66.306a1.749 1.749 0 0 1-1.75-1.75v-53.85a1.749 1.749 0 0 1 1.75-1.75h15.908a1.749 1.749 0 0 1 1.75 1.75v53.85a1.749 1.749 0 0 1-1.75 1.75zm-14.158-3.5h12.408v-50.35H68.056zM113.047 123.443H97.138a1.749 1.749 0 0 1-1.75-1.75V64.144h-4.77a1.75 1.75 0 0 1-1.237-2.988l14.474-14.474a1.75 1.75 0 0 1 1.238-.513 1.746 1.746 0 0 1 1.237.513l14.47 14.474a1.75 1.75 0 0 1-1.238 2.988H114.8v57.549a1.749 1.749 0 0 1-1.753 1.75zm-14.159-3.5H111.3V62.394a1.749 1.749 0 0 1 1.75-1.75h2.3l-10.249-10.25-10.25 10.25h2.3a1.75 1.75 0 0 1 1.75 1.75z" />
                    </svg>
                </div>
                <div>
                    <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                        Ongoing Appointment
                    </p>
                    <p class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                        {{ number_format(0) }}
                    </p>
                </div>
            </div>
        </div>
    </x-filament::section>

    <x-filament::section>
        <div class="min-w-0 rounded-lg shadow-xs overflow-hidden bg-white dark:bg-gray-800 ">
            <div class="p-4 flex items-center">
                <div class="p-3 rounded-full bg-red-100 dark:bg-red-300 mr-4">
                    <svg fill="currentColor" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" xml:space="preserve"
                        class="w-10 h-10"
                        style="fill-rule:evenodd;clip-rule:evenodd;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:2">
                        <path d="m37.278 14.519-21.203-2.45a4 4 0 0 0-4.433 3.514l-.763 6.606"
                            style="fill:none;stroke:#222a33;stroke-width:2px" />
                        <path
                            d="m15.001 20.404.322-2.782a1.867 1.867 0 0 1 2.069-1.641l2.976.344M53.202 19.117a4.001 4.001 0 0 0-4.609-3.28l-38.149 6.425a4.001 4.001 0 0 0-3.28 4.609l3.634 21.575a4 4 0 0 0 4.609 3.28l38.149-6.425a4.003 4.003 0 0 0 3.28-4.609l-3.634-21.575z"
                            style="fill:none;stroke:#222a33;stroke-width:2px" />
                        <path
                            d="m19.474 47.253-2.823.476a1.999 1.999 0 0 1-2.305-1.64l-.443-2.632m30.623-23.148 2.823-.475a1.998 1.998 0 0 1 2.305 1.64l.443 2.631m-38.365 6.462-.443-2.632a1.999 1.999 0 0 1 1.64-2.304l2.823-.476M52.268 36.996l.443 2.631a1.999 1.999 0 0 1-1.64 2.305l-2.823.475M33.221 29.788A2.334 2.334 0 1 0 32 33.781a2.336 2.336 0 0 1 2.69 1.914 2.336 2.336 0 0 1-3.911 2.079M31.225 29.177l-.311-1.841M33.086 40.226l-.311-1.841"
                            style="fill:none;stroke:#222a33;stroke-width:2px" />
                    </svg>
                </div>
                <div>
                    <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                        Current Patients
                    </p>
                    <p class="text-lg font-semibold text-gray-700 dark:text-gray-200 ">
                        {{ number_format(0) }}
                    </p>
                </div>
            </div>
        </div>
    </x-filament::section>

</div>
